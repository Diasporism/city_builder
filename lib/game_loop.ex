defmodule GameLoop do
  use GenServer

  @milliseconds_per_tick 16
  defstruct previous_time: nil, lag: 0

  def init(_arg) do
    state = %GameLoop{previous_time: System.monotonic_time(:millisecond)}
    tick()
    {:ok, state}
  end

  def handle_info(:tick, state) do
    current_time = System.monotonic_time(:millisecond)
    lag          = current_time - state.previous_time + state.lag
    state        = %{state | previous_time: current_time, lag: lag}

    process_input()
    state      = update(state)
    delta_time = state.lag / @milliseconds_per_tick
    render(delta_time)

    tick()
    {:noreply, state}
  end

  defp process_input do
    # Simulate input processing time
    Process.sleep(1)
  end

  defp update(state) do
    case state.lag do
      lag when lag >= @milliseconds_per_tick ->
        state = %{state | lag: lag - @milliseconds_per_tick}
        update(state)
      _ ->
        state
    end
  end

  defp render(_delta_time) do
    # Simulate rendering time
    Process.sleep(6)
  end

  defp tick do
    send(self(), :tick)
  end
end
