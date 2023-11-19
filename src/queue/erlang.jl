module ErlangC

using Parameters

export ErlangCData, traffic_intensity

@with_kw struct ErlangCData
    arrivals::Int = 0
    interval::Int = 15
    handling_time::Float64 = 0.5
    speed_of_answer::Float64 = 0.0
    num_agents::Int = 0
    service_level::Float64 = 0.8

    function ErlangCData(arrivals, interval, handling_time, speed_of_answer, num_agents, service_level)
        """
        Create an instance of ErlangCData.

        Parameters:
        - arrivals: Number of arrivals.
        - interval: Time interval.
        - handling_time: Call handling time.
        - speed_of_answer: Service time.
        - num_agents: Number of servers.
        - service_level: Desired service level (between 0 and 1).

        Returns:
        An ErlangCData object.
        """
        @assert arrivals >= 0 || throw(ArgumentError("Arrival rate must be a non-negative number."))
        @assert interval >= 0 || throw(ArgumentError("Interval rate must be a non-negative number."))
        @assert handling_time > 0.0 || throw(ArgumentError("Call duration must be a positive number."))
        @assert speed_of_answer >= 0.0 || throw(ArgumentError("Service time must be a positive number."))
        @assert num_agents >= 0 || throw(ArgumentError("Number of servers must be a positive integer."))
        @assert 0.0 <= service_level <= 1.0 || throw(ArgumentError("Service level must be between 0 and 1."))

        return new(arrivals, interval, handling_time, speed_of_answer, num_agents, service_level)
    end
end


function traffic_intensity(data::ErlangCData)
    """
    Calculate the arrival intensity
    """
    return (data.arrivals * data.handling_time) / data.interval
end

end