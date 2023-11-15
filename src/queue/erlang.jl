using Parameters

export ErlangCData

@with_kw struct ErlangCData
    arrival_rate::Float64 = 0.0
    call_duration::Float64 = 0.0
    service_time::Float64 = 0.0
    num_servers::Int = 0
    service_level::Float64 = 80.0

    function ErlangCData(arrival_rate, call_duration, service_time, num_servers, service_level)
        @assert arrival_rate >= 0.0 || throw(ArgumentError("Arrival rate must be a non-negative number."))
        @assert call_duration >= 0.0 || throw(ArgumentError("Call duration must be a positive number."))
        @assert service_time >= 0.0 || throw(ArgumentError("Service time must be a positive number."))
        @assert num_servers >= 0 || throw(ArgumentError("Number of servers must be a positive integer."))
        @assert 0.0 <= service_level <= 100.0 || throw(ArgumentError("Service level must be between 0 and 100."))

        return new(arrival_rate, call_duration, service_time, num_servers, service_level)
    end
end
