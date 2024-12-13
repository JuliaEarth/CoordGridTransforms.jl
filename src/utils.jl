# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENSE in the project root.
# ------------------------------------------------------------------

# maximum number of iterations in iterative algorithms
const MAXITER = 10

"""
    atol(T)
    atol(x::T)

Absolute tolerance used in source code for approximate
comparison with numbers of type `T`.
"""
atol(x) = atol(typeof(x))
atol(::Type{Float64}) = 1e-10
atol(::Type{Float32}) = 1.0f-5
