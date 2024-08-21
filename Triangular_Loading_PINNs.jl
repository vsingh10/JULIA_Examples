using Pkg

Pkg.add(["NeuralPDE", "Symbolics", "ModelingToolkit", "DifferentialEquations", "Flux", "Plots", "Optimization", "OptimizationOptimisers"])

using NeuralPDE, Flux, DifferentialEquations, ModelingToolkit, Plots, Symbolics, Optimization, OptimizationOptimisers 

@parameters t
@variables u(..)

Dx = Differential(t)
Dxx = Differential(t)^2
Dxxx = Differential(t)^3
D = Differential(t)^4

E = 1.0
I = 1.0 
L = 2.7
q_o = 60
load = (q_o * (L - t))/L

# Define the differential equation
eq = E*I*D(u(t)) ~ -load

# Initial condition
bcs = [u(0) ~ 0, Dx(u(0)) ~ 0, Dxx(u(L)) ~ 0, Dxxx(u(L)) ~ 0]

domains = [t ∈ IntervalDomain(0.0, 2.7)]

# Neural network model
neural_net = Chain(Dense(1, 50, tanh), Dense(50, 1))

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

res = Optimization.solve(prob, ADAM(0.01); callback = callback, maxiters = 20000)
prob = remake(prob, u0 = res.minimizer)
res = Optimization.solve(prob, ADAM(0.001); callback = callback, maxiters =10000)
phi = discretization.phi

# Time values for evaluation
t_vals = 0.0:0.01:2.7

# Predict the solution using the trained neural network
u_pred = [first(phi([t], res.minimizer)) for t in t_vals]

# Exact solution for comparison
u_exact = ((-q_o*(t^2))/(120*L*E*I))*(10*L^3 - 10*t*L^2 + 5*L*t^2 - t^3)

# Plotting the predicted solution and the exact solution
plot(t_vals, u_pred, label="PINN Solution", lw=2, xlabel="t", ylabel="v(t)")
plot!(t_vals, u_exact, label="Exact Solution", lw=2, linestyle=:dash, color=:red)

title!("PINN Deflection vs Exact Deflection")

# Final loss value
println("Final loss: ", res.minimum)


