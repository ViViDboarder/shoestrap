# Generate and source completions for fish

# Source kubectl completions
if type -q kubectl
    kubectl completion fish | source
end

# Source colima completions
if type -q colima
    colima completion fish | source
end

# Source golangci-lint completions
if type -q golangci-lint
    golangci-lint completion fish | source
end
