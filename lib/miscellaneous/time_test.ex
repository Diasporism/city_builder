defmodule TimeTest do
  use GenServer

  def init(_arg) do
    tick()
    {:ok, []}
  end

  def handle_info(_msg, state) do
    tick()
    {:noreply, state}
  end

  defp tick do
    # time = System.monotonic_time(:millisecond) + 1000
    print_time()
    Process.send_after(self(), :tick, 1000)
  end

  defp print_time do
    time = DateTime.utc_now()
      |> DateTime.to_time()
      |> Time.to_iso8601()

    IO.inspect(time)
  end
end

GenServer.start_link(TimeTest, [])
