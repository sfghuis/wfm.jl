using Test

include(joinpath(@__DIR__,"src", "queue", "erlang.jl"))


@testitem "Sanity test" begin
    @test 1 + 1 == 2
    @test_throws DomainError sqrt(-1)
end

@testitem "ErlangCData Tests" begin

    #using wfm.erlang
    
    # Valid data
    @test ErlangCData(arrival_rate=50.0, call_duration=0.1, service_time=0.05, num_servers=10, service_level=80.0) isa ErlangCData

    #Invalid arrival_rate (negative value)
    @test_throws ArgumentError ErlangCData(arrival_rate=-50.0, call_duration=0.1, service_time=0.05, num_servers=10, service_level=80.0)

    # Invalid call_duration (negative value)
    @test_throws ArgumentError ErlangCData(arrival_rate=50.0, call_duration=-0.1, service_time=0.05, num_servers=10, service_level=80.0)

    # Invalid service_time (negative value)
    @test_throws ArgumentError ErlangCData(arrival_rate=50.0, call_duration=0.1, service_time=-0.05, num_servers=10, service_level=80.0)

    # Invalid num_servers (negative value)
    @test_throws ArgumentError ErlangCData(arrival_rate=50.0, call_duration=0.1, service_time=0.05, num_servers=-10, service_level=80.0)

    # Invalid service_level (greater than 100)
    @test_throws ArgumentError ErlangCData(arrival_rate=50.0, call_duration=0.1, service_time=0.05, num_servers=10, service_level=120.0)
end