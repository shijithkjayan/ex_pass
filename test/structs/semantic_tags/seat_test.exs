defmodule ExPass.Structs.SemanticTags.SeatTest do
  @moduledoc false
  use ExUnit.Case, async: true
  alias ExPass.Structs.SemanticTags.Seat

  doctest Seat

  describe "new/0" do
    test "creates an empty Seat struct" do
      assert %Seat{} = Seat.new()
    end
  end

  describe "new/1 with seat_type" do
    test "creates a valid Seat struct with seat_type" do
      params = %{seat_type: "Reserved seating"}

      assert %Seat{} = seat = Seat.new(params)
      assert seat.seat_type == "Reserved seating"

      encoded = Jason.encode!(seat)
      assert encoded =~ ~s("seatType":"Reserved seating")
    end

    test "creates a valid Seat struct without seat_type" do
      assert %Seat{} = seat = Seat.new(%{})
      refute seat.seat_type

      encoded = Jason.encode!(seat)
      refute encoded =~ "seatType"
    end

    test "trims whitespace from seat_type" do
      params = %{seat_type: "  Reserved seat  "}

      assert %Seat{} = seat = Seat.new(params)
      assert seat.seat_type == "Reserved seat"
    end

    test "returns error for non-string seat_type" do
      params = %{seat_type: 123}

      assert_raise ArgumentError, "seat_type must be a string if provided", fn ->
        Seat.new(params)
      end
    end

    test "allows empty string for seat_type" do
      params = %{seat_type: ""}

      assert %Seat{} = seat = Seat.new(params)
      assert seat.seat_type == ""
    end
  end

  describe "new/1 with seat_description" do
    test "creates a valid Seat struct with seat_description" do
      params = %{seat_description: "Push back seat"}

      assert %Seat{} = seat = Seat.new(params)
      assert seat.seat_description == "Push back seat"

      encoded = Jason.encode!(seat)
      assert encoded =~ ~s("seatDescription":"Push back seat")
    end

    test "creates a valid Seat struct without seat_description" do
      assert %Seat{} = seat = Seat.new(%{})
      refute seat.seat_description

      encoded = Jason.encode!(seat)
      refute encoded =~ "seatDescription"
    end

    test "trims whitespace from seat_description" do
      params = %{seat_description: "  Push back seat  "}

      assert %Seat{} = seat = Seat.new(params)
      assert seat.seat_description == "Push back seat"
    end

    test "returns error for non-string seat_description" do
      params = %{seat_description: 123}

      assert_raise ArgumentError, "seat_description must be a string if provided", fn ->
        Seat.new(params)
      end
    end

    test "allows empty string for seat_description" do
      params = %{seat_description: ""}

      assert %Seat{} = seat = Seat.new(params)
      assert seat.seat_description == ""
    end
  end
end
