defmodule Cortex do
  @moduledoc """
  The cortex handles neuron and actuator generation. Additionally, it generates input and
  creates a map of pids for communication.
  """
  #This is where the problem starts: I was seeking to make a 3-1 NN,
  #such that the first layer would feed a vector length 3 to the second
  #layer. I began specifying the creation of the neurons in here.
  #unhappy with the fact that it cascaded to a number of hard code
  #changes, I dropped the idea. I'm saving what I did do, though so
  #I can learn from it.
end
  def start_link do
    #There is a more concise way, rather than hard coding. I'll figure that out later.
    {:ok, neuron1a} = Neuron.start_link
    {:ok, neuron1b} = Neuron.start_link
    {:ok, neuron1c} = Neuron.start_link
    {:ok, neuron2} = Neuron.start_link
    {:ok, actuator} = Actuator.start_link
    pids = %{:self => self(),
             #PID's need to be fed to a neuron list, rather than mapped out like this
             #Clearly, the generation function needs to spawn or update a bucket with
             #associated pid's. See elixir guide on agents, particularly updating.
             :neuron1a => neuron1a,
             :neuron1b => neuron1b,
             :neuron1c => neuron1c,
             :neuron2 => neuron2,
             :actuator => actuator}
    Task.start_link(fn -> loop(pids) end)
  end

  defp loop(pids) do
    receive do

        #This will generate random input to be sent to the actuator.
      {:sense} ->
        input = [Enum.random(0..1), Enum.random(0..1), (Enum.random(0..100))/100]
        metadata = Map.put(pids, :input, input)
        Sense.input(metadata[:neuron1a], metadata)
        Sense.input(metadata[:neuron1b], metadata)
        Sense.input(metadata[:neuron1c], metadata)
        loop(pids)

        #Some test code to make sure the metadata is being utilized properly.
      {:feedback} ->
        metadata = Map.put(pids, :msg, "hellomichael")
        send metadata[:self], {:ok, metadata}
        loop(pids)
    end
  end
end
