defmodule Neuron do
  @moduledoc """
  Creates a simple neuron, with 2 random weights and a random bias.
  Neuron receives input vector of length 3, generates Weight*input
  dot product. Arbitrary activation function is applied to the dot
  product, which produces a final output, which is sent to corresponding
  actuator.
  Must be sure to use the following send
  send neuron, {:ok, self(), neuron_pid, actuator_pid, input_vector}
  """


  def layer1.start_link do
    weights = [Enum.random(0..100)/100, Enum.random(0..100)/100, Enum.random(0..100)/100]
    Task.start_link(fn -> loop(weights) end)
  end

  def layer2.start_link do
    weights = [Enum.random(0..100)/100, Enum.random(0..100)/100, Enum.random(0..100)/100]
    Task.start_link(fn -> loop(layer2_weights) end)
  end

  #Changes in cortex and the addition of a new layer cascaded to the neurons and began to
  #require much more alteration and addition than I wanted. The neuron must be reconfigured
  #to automatically send to an associated list of PIDS, rather than a specified actuator.
  #
  defp loop(weights) do
    receive do
      {:ok, metadata} -> 
        dot_product = Vector.dot_product(metadata[:input], weights)
        output = :math.tanh(dot_product)
      send metadata[:neuron2], {:ok, output, metadata}
      loop(weights)
    end
  end

  defp loop(layer2_weights) do
    vector = []
    receive do
      {:ok, output, metadata} -> 
        Agent.update()
        dot_product = Vector.dot_product(metadata[:input], weights)
        output = :math.tanh(dot_product)
      send metadata[:actuator], {:ok, output, metadata}
      loop(weights)
    end
  end
end
