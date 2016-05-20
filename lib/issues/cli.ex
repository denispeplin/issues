defmodule Issues.CLI do
  @default_count 4

  @moduledoc """
  Handle the command line parsing for the project
  """

  @doc """
  `argv` can be -h or --help, which returns :help
  Otherwise, it is a Github username, project name, and (optionally)
    the number of entries to format.

  Return is a tuple of `{ user, project, count }`, or `:help`,
    if help was given.
  """
  def parse_args(argv) do
    case parse(argv) do
      { _, [user, project, count], _ }
        -> { user, project, String.to_integer(count) }
      { _, [user, project], _ }
        -> { user, project, @default_count }
      _ -> :help
    end
  end

  defp parse(argv) do
    OptionParser.parse(argv, switches: [:help, :boolean], aliases: [h: :help])
  end
end
