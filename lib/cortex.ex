defmodule Cortex do
  @moduledoc """
  The cortex handles neuron and actuator generation. Additionally, it generates input and
  creates a map of pids for communication.
  """
  def start_link do
    {:ok, neuron} = Neuron.start_link
    {:ok, actuator} = Actuator.start_link
    pids = %{:self => self(), :neuron => neuron, :actuator => actuator}
    Task.start_link(fn -> loop(pids) end)
  end

  defp loop(pids) do
    receive do

        #This will generate random input to be sent to the actuator.
      {:sense, input} ->
        #input is [i1, i2, i3, 1] where 1 is to allow for bias
        #input = [Enum.random(0..1), Enum.random(0..1), (Enum.random(0..100))/100]
        metadata = Map.put(pids, :input, input)
        Sense.input(metadata[:neuron], metadata)
        loop(pids)

        #Some test code to make sure the metadata is being utilized properly.
      {:feedback} ->
        metadata = Map.put(pids, :msg, "hellomichael")
        send metadata[:self], {:ok, metadata}
        loop(pids)
    end
  end
end
