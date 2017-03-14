
defmodule Actuator do
  @moduledoc """
  Creates a simple actuator which receives output from simple neuron in
  format: {:doesthiswork, output, self_pid}. The final output is sent
  to the iex process, along with the atom - :actuator_firing.
  """


  @doc """
  threshold is an arbitrary value. Not sure if I need to
  have it in there. It's a placeholder so the loop function works.
  """
  def start_link do
    threshold = 5
    Task.start_link(fn ->loop(threshold) end)
  end

  defp loop(threshold) do
    receive do
      {:doesthiswork, output, metadata} ->
        final = output
    send metadata[:self], {:actuator_firing, output, final, metadata}
    loop(threshold)
    end
  end
end
