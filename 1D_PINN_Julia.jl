using Pkg

Pkg.add(["NeuralPDE", "Symbolics", "ModelingToolkit", "DifferentialEquations", "Flux", "Plots", "Optimization", "OptimizationOptimisers"])

using NeuralPDE, Flux, DifferentialEquations, ModelingToolkit, Plots, Symbolics, Optimization, OptimizationOptimisers 

@parameters t
@variables u(..)

D = Differential(t)

# Define the differential equation
eq = D(u(t)) ~ -u(t)

# Initial condition
bcs = [u(0) ~ 1.0]

domains = [t ∈ IntervalDomain(0.0, 2.0)]

# Neural network model
neural_net = Chain(Dense(1, 10, tanh), Dense(10, 1))

# Neural PDE problem setup
strategy = GridTraining(0.01)
discretization = PhysicsInformedNN(neural_net, strategy)

# Set up the optimization problem
@named pde_system = PDESystem(eq, bcs, domains, [u], [u(t)])

# Set up the optimization problem
prob = NeuralPDE.discretize(pde_system, discretization)

callback = function (p, l)
    println("Current loss is: $l")
    return false
end

res = Optimization.solve(prob, ADAM(0.1); callback = callback, maxiters = 4000)
prob = remake(prob, u0 = res.minimizer)
res = Optimization.solve(prob, ADAM(0.01); callback = callback, maxiters = 2000)
phi = discretization.phi

# Time values for evaluation
t_vals = 0.0:0.01:2.0

# Predict the solution using the trained neural network
u_pred = [first(phi([t], res.minimizer)) for t in t_vals]

# Exact solution for comparison
u_exact = exp.(-t_vals)

# Plotting the predicted solution and the exact solution
plot(t_vals, u_pred, label="PINN Solution", lw=2, xlabel="t", ylabel="u(t)")
plot!(t_vals, u_exact, label="Exact Solution", lw=2, linestyle=:dash, color=:red)

title!("PINN vs Exact Solution")

# Final loss value
println("Final loss: ", res.minimum)


