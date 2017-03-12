defmodule Create do
  @moduledoc """
  An attempt to shorten the process. However, it's not working. I'm
  not sure if I need to throw this stuff into a .iex file or what.
  Could be an issue of variables not being created globally. 
  """
  def neuron do
    {:ok, neuron} = Neuron.start_link
  end

  def actuator() do
    {:ok, actuator} = Actuator.start_link
  end

  def sensor() do
    {:ok, sensor} = Sensor.start_link
  end
end

defmodule Sense do
  def input(input, neuron, map) do
    send neuron, {map, input}
  end
end
