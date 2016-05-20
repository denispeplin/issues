defmodule Issues.GithubIssues do
  def fetch(user, project) do
    issues_url(user, project)
      |> HTTPoison.get
      |> handle_response
  end

  defp issues_url(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end

  defp handle_response(response) do
    case response do
      { :ok, %HTTPoison.Response{ status_code: 200, body: body } } ->
        { :ok, :jsx.decode(body) }
      { :ok, %HTTPoison.Response{ status_code: ___, body: body } } ->
        { :error, :jsx.decode(body) }
    end
  end
end
