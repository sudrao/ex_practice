defmodule Bert.Worker do
  require Logger

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, [name: :worker1])
  end
  
  def init(:ok) do
    Logger.info("Worker started")
    # Process.flag(:trap_exit, true) # only needed to trap signals, not terminations (exceptions, links)
    Process.send_after(self(), :timer, 5000)
    {:ok, []}
  end
  
  # External signals will land here
  def handle_info({:EXIT,_pid, msg}, state) do
    Logger.error "Worker1 exited with msg: #{inspect(msg)}, state: #{inspect(state)}"
    exit(1)
  end
  # This is to test exceptions
  def handle_info(:timer, _state) do
    raise "Timer expired in worker1"
  end
  
  # Exceptions and linked process exit will land here
  # This is a good place to save state (in ETS or file) before exiting.
  def terminate(reason, _state) do
    Logger.error("Worker1 terminating here because #{inspect(reason)}")
  end
end
