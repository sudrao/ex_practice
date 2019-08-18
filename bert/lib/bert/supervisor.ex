# The reason to have a module based supervisor is to do something extra like
# create a ETS table that is updated by the child. After the child restarts,
# it can get state information from that table if it saved something before
# exiting. The child's terminate function is a good place to save state.
# We aren't showing that here, so this module wasn't necessary except to document.
defmodule Bert.Supervisor do

  require Logger
  
  def start_link(_opts) do
    Supervisor.start_link(__MODULE__, [], name: :bert_supervisor)
  end
  
  def init([]) do
    Logger.info("Starting worker")
    children = [
      %{
        id: :bert_worker,
        start: {Bert.Worker, :start_link, []},
        restart: :transient
      }
    ]
    opts = [strategy: :one_for_one]
    Supervisor.init(children, opts)
  end
  
end
