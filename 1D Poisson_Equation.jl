using Pkg

Pkg.add(["Optimisers", "Zygote", "Plots", "Random", "Distributions"])

using Optimisers, Zygote, Plots, Random, Distributions

SEED = 42
N_collocation_points = 51
HIDDEN_DEPTH = 100
LEARNING_RATE = 1e-3
N_EPOCHS = 20_000
BC_LOSS_WEIGHT = 100.0

rhs_function(x) = sin(pi*x)

analytical_solution(x) = sin(pi*x)/pi^2

rng = MersenneTwister(SEED)

sigmoid(x) = 1.0 / (1.0 + exp(-x))

#Initialise the weights according to the Xavier Glorot Initializer
uniform_limit = sqrt(6 / (1 + HIDDEN_DEPTH))
W = rand(
    rng,
    Uniform(-uniform_limit, +uniform_limit),
    HIDDEN_DEPTH,
    1,
)
V = rand(
    rng,
    Uniform(-uniform_limit, +uniform_limit),
    1,
    HIDDEN_DEPTH,
)
b = zeros(HIDDEN_DEPTH)

parameters = (; W, V, b)

network_forward(x, p) = p.V * sigmoid.(p.W * x .+ p.b)

x_line = reshape(collect(range(0.0, stop = 1.0, length = 100)), (1, 100))

plot(x_line[:], network_forward(x_line, parameters)[:], labels = "initial prediction")
plot!(x_line[:], analytical_solution.(x_line[:]), label="analytical_solution")

function network_output_and_first_two_derivatives(x, p)
    activated_state = sigmoid.(p.W * x .+ p.b)
    sigmoid_prime = activated_state .* (1.0 .- activated_state)
    sigmoid_double_prime = sigmoid_prime .* (1.0 .- 2.0 .* activated_state)

    output = p.V * activated_state
    first_derivative = (p.V .* p.W') * sigmoid_prime
    second_derivative = (p.V .* p.W' .* p.W') * sigmoid_double_prime

    return output, first_derivative, second_derivative
end

_output, _first_derivative, _second_derivative = network_output_and_first_two_derivatives(x_line, parameters)

_first_derivative

_zygote_first_derivative = Zygote.gradient(x-> sum(network_forward(x, parameters)), x_line)[1]

interior_collocation_points = rand(rng, Uniform(0.0, 1.0), (1, N_collocation_points))   

boundary_collocation_points = [0.0 1.0]

function loss_forward(p)
    output, first_derivative, second_derivative = network_output_and_first_two_derivatives(
        interior_collocation_points,
        p,
    )

    interior_residuals = second_derivative .+ rhs_function.(interior_collocation_points)

    interior_loss = 0.5 * mean(interior_residuals.^2)

    boundary_residuals = network_forward(boundary_collocation_points, p) .- 0.0

    boundary_loss = 0.5 * mean(boundary_residuals.^2)

    total_loss = interior_loss + BC_LOSS_WEIGHT * boundary_loss

    return total_loss
end

loss_forward(parameters)

out, back = Zygote.pullback(loss_forward, parameters)

back(1.0)[1]

opt = Adam(LEARNING_RATE)

opt_state = Optimisers.setup(opt, parameters)
loss_history = []
for i in 1:N_EPOCHS
    loss, back = Zygote.pullback(loss_forward, parameters)
    push!(loss_history, loss)
    grad, = back(1.0)
    opt_state, parameters = Optimisers.update(opt_state, parameters, grad)
    if i % 100 == 0
        println("Epoch:$i,Loss:$loss")
    end
end

plot(loss_history, yscale=:log10)

# Plot the network prediction with markers
plot(x_line[:], network_forward(x_line, parameters)[:], 
     label="final prediction", 
     marker=:circle,          # Marker shape (e.g., :circle, :rect, :star, etc.)
     markersize=4,            # Size of the markers
     markeralpha=0.8)         # Transparency of the markers

# Plot the analytical solution with different markers
plot!(x_line[:], analytical_solution.(x_line[:]), 
      label="analytical_solution")        # Same transparency


