defmodule ExPass.Structs.Locations do
  @moduledoc """
  Represents a location that the system uses to show a relevant pass.

  ## Fields

  * `:altitude` - The altitude, in meters, of the location. This is a double-precision floating-point number.
  * `:latitude` - (Required) The latitude, in degrees, of the location. This is a double-precision floating-point number between -90 and 90.
  * `:longitude` - (Required) The longitude, in degrees, of the location. This is a double-precision floating-point number between -180 and 180.

  ## Compatibility

  - iOS 6.0+
  - iPadOS 6.0+
  - watchOS 2.0+
  """

  use TypedStruct

  alias ExPass.Utils.Converter
  alias ExPass.Utils.Validators

  typedstruct do
    field :altitude, float()
    field :latitude, float(), enforce: true
    field :longitude, float(), enforce: true
  end

  @doc """
  Creates a new Locations struct.

  ## Parameters

    * `attrs` - A map of attributes for the Locations struct. The map can include the following keys:
      * `:altitude` - (Optional) The altitude, in meters, of the location. This should be a double-precision floating-point number.
      * `:latitude` - (Required) The latitude, in degrees, of the location. This should be a double-precision floating-point number between -90 and 90.
      * `:longitude` - (Required) The longitude, in degrees, of the location. This should be a double-precision floating-point number between -180 and 180.

  ## Returns

    * A new `%Locations{}` struct.

  ## Examples

      iex> Locations.new(%{latitude: 37.7749, longitude: -122.4194})
      %Locations{altitude: nil, latitude: 37.7749, longitude: -122.4194}

      iex> Locations.new(%{altitude: 100.5, latitude: 37.7749, longitude: -122.4194})
      %Locations{altitude: 100.5, latitude: 37.7749, longitude: -122.4194}

      iex> Locations.new(%{latitude: -50.75, longitude: 165.3})
      %Locations{altitude: nil, latitude: -50.75, longitude: 165.3}

      iex> Locations.new(%{latitude: "invalid", longitude: 0.0})
      ** (ArgumentError) latitude must be a float

      iex> Locations.new(%{latitude: 37.7749})
      ** (ArgumentError) longitude is required

      iex> Locations.new(%{latitude: 91.0, longitude: 0.0})
      ** (ArgumentError) latitude must be between -90 and 90

      iex> Locations.new(%{latitude: 37.7749, longitude: 181.0})
      ** (ArgumentError) longitude must be between -180 and 180

  """
  @spec new(map()) :: %__MODULE__{}
  def new(attrs \\ %{}) do
    attrs =
      attrs
      |> validate(:altitude, &Validators.validate_optional_float(&1, :altitude))
      |> validate(:latitude, &Validators.validate_latitude(&1, :latitude))
      |> validate(:longitude, &Validators.validate_longitude(&1, :longitude))

    struct!(__MODULE__, attrs)
  end

  defp validate(attrs, key, validator) do
    case validator.(attrs[key]) do
      :ok ->
        attrs

      {:error, reason} ->
        raise ArgumentError, reason
    end
  end

  defimpl Jason.Encoder do
    def encode(field_content, opts) do
      field_content
      |> Map.from_struct()
      |> Enum.reduce(%{}, fn
        {_k, nil}, acc -> acc
        {k, v}, acc -> Map.put(acc, Converter.camelize_key(k), v)
      end)
      |> Jason.Encode.map(opts)
    end
  end
end
