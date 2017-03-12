defmodule Cortex do
  @moduledoc """
  The cortex handles neuron and actuator generation. Additionally, it generates input and
  creates a map of pids for communication.
  """
  def start_link do
    {:ok, neuron} = Neuron.start_link
    {:ok, actuator} = Actuator.start_link
    metadata = %{:self => self(), :neuron => neuron, :actuator => actuator}
    Task.start_link(fn -> loop(metadata) end)
  end

  defp loop(metadata) do
    receive do

        #This will generate random input to be sent to the actuator.
      {:sense} ->
        input = [1,1,1]#[Enum.random(0..1), Enum.random(0..1), (Enum.random(0..100))/100]
        Map.put(metadata, :input, input)
        Sense.input(metadata[:neuron], metadata)
        loop(metadata)

        #Some test code to make sure the metadata is being utilized properly.
      {:feedback} ->
        send metadata[:self], {:ok, :thisworks}
        loop(metadata)
    end
  end
end
