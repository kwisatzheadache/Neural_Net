
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
      {:doesthiswork, output, metadata} ->
        #final = output
        #while the dotproduct is inoperable, I'm just using test statements
    send metadata[:self], {:actuator_firing, output, metadata}
    loop(threshold)
    end
  end
end
