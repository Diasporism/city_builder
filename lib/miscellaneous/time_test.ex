defmodule TimeTest do
  use GenServer

  defstruct prev_time: nil

  def init(_arg) do
    Process.flag(:priority, :max)
    state = %TimeTest{prev_time: System.monotonic_time(:millisecond)}
    tick(state.prev_time)
    {:ok, state}
  end

  def handle_info(_msg, state) do
    tick(state.prev_time)
    {:noreply, state}
  end

  defp tick(prev_time) do
    time = prev_time + 1000
    print_time()
    Process.send_after(self(), :tick, time, abs: true)
    # Process.send_after(self(), :tick, 1000)
  end

  defp print_time do
    time = DateTime.utc_now()
      |> DateTime.to_time()
      |> Time.to_iso8601()

    IO.inspect(time)
  end
end
