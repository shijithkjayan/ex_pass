defmodule ExPass.Structs.SemanticTags.Seat do
  @moduledoc """
  Represents  the identification of a seat for a transit journey or an event.

  ## Fields

  * `:seat_type` - Optional. The type of seat, such as “Reserved seating”.
  * `:seat_description` - Optional. A description of the seat, such as “A flat bed seat“.
  * `:seat_identifier` - Optional. A unique identifier for the seat, such as “Aisle 12, Row 3, Seat 5”.

  ## Compatibility

  - iOS 12.0+
  - iPadOS 6.0+
  - watchOS 2.0+
  """

  use ExPass.Structs.Base
  use TypedStruct

  alias ExPass.Utils.Converter
  alias ExPass.Utils.Validators

  typedstruct do
    field :seat_type, String.t()
    field :seat_description, String.t()
    field :seat_identifier, String.t()
  end

  @doc """
  Creates a new Seat struct.

  ## Parameters

    * `attrs` - A map of attributes for the Seat struct. The map can include the following keys:
      * `:seat_type` - (Optional) The type of seat, such as “Reserved seating”.
      * `:seat_description` - (Optional) A description of the seat, such as “A flat bed seat“.
      * `:seat_identifier` - (Optional) A unique identifier for the seat, such as “Aisle 12, Row 3, Seat 5”.

  ## Returns

    * A new `%Seat{}` struct.

  ## Examples

      iex> Seat.new(%{seat_type: "Reserved seating", seat_description: "A push back seat", seat_identifier: "Aisle 12, Row 3, Seat 5"})
      %Seat{seat_type: "Reserved seating", seat_description: "A push back seat", seat_identifier: "Aisle 12, Row 3, Seat 5"}

      iex> Seat.new(%{seat_type: 123})
      ** (ArgumentError) seat_type must be a string if provided

  """
  @spec new(map()) :: %__MODULE__{}
  def new(attrs \\ %{}) do
    attrs =
      attrs
      |> Converter.trim_string_values()
      |> validate(:seat_type, &Validators.validate_optional_string(&1, :seat_type))
      |> validate(:seat_description, &Validators.validate_optional_string(&1, :seat_description))
      |> validate(:seat_identifier, &Validators.validate_optional_string(&1, :seat_identifier))

    struct!(__MODULE__, attrs)
  end
end
