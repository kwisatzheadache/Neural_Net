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


  def start_link do
    weights = [Enum.random(0..100)/100, Enum.random(0..100)/100, Enum.random(0..100)/100]
    Task.start_link(fn -> loop(weights) end)
  end

  defp loop(weights) do
    receive do
      {:ok, self, neuron, actuator, input} -> #tuple is sensor label, pid, and [i1, i2] vector
        dot_product = Vector.dot_product(input, weights)
        output = :math.tanh(dot_product)
      send actuator, {:doesthiswork, output, self}
      loop(weights)
    end
  end
end

defmodule Actuator do
  @moduledoc """
  Creates a simple actuator which receives output from simple neuron in
  format: {:doesthiswork, output, self_pid}. The final output is sent
  to the iex process, along with the atom - :actuator_firing.
  """
  def start_link do
    threshold = 5
    Task.start_link(fn ->loop(threshold) end)
  end

  defp loop(threshold) do
    receive do
      {:doesthiswork, output, self_pid} ->
        final = output
    send self_pid, {:actuator_firing, output}
    loop(threshold)
    end
  end
end