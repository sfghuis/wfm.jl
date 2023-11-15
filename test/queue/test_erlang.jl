using Test

include(joinpath(@__DIR__,"src", "queue", "erlang.jl"))


@testitem "Sanity test" begin
    @test 1 + 1 == 2
    @test_throws DomainError sqrt(-1)
end

@testitem "ErlangCData Tests" begin

    #using wfm.erlang
    
    # Valid data
    @test ErlangCData(arrivals=50.0, handling_time=0.1, speed_of_answer=0.05, num_agents=10, service_level=.8) isa ErlangCData

    #Invalid arrivals (negative value)
    @test_throws ArgumentError ErlangCData(arrivals=-50.0, handling_time=0.1, speed_of_answer=0.05, num_agents=10, service_level=.8)

    # Invalid interval (non-interger)
    @test_throws ArgumentError ErlangCData(arrivals=50.0, interval=.8, handling_time=0.1, speed_of_answer=0.05, num_agents=10, service_level=1.2)

    # Invalid handling_time (negative value)
    @test_throws ArgumentError ErlangCData(arrivals=50.0, handling_time=-0.1, speed_of_answer=0.05, num_agents=10, service_level=.8)

    # Invalid speed_of_answer (negative value)
    @test_throws ArgumentError ErlangCData(arrivals=50.0, handling_time=0.1, speed_of_answer=-0.05, num_agents=10, service_level=.8)

    # Invalid num_agents (negative value)
    @test_throws ArgumentError ErlangCData(arrivals=50.0, handling_time=0.1, speed_of_answer=0.05, num_agents=-10, service_level=.8)

    # Invalid service_level (greater than 100)
    @test_throws ArgumentError ErlangCData(arrivals=50.0, handling_time=0.1, speed_of_answer=0.05, num_agents=10, service_level=1.2)
end

@testitem "Erlang C intensity calculation" begin
    
    test_data = ErlangCData(arrivals=200, interval=60, handling_time=3, speed_of_answer=20/60, num_agents=10, service_level=.80)
    @test traffic_intensity(test_data) == 10
end