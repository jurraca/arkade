defmodule Arkade.Csv do
  @moduledoc """
      Take in a CSV, format fields, return a data structure that matches the DB schema.
  """

  NimbleCSV.define(Parser, [])

  def parse(csv_string) when is_binary(csv_string) do
    csv_string
    |> Parser.parse_string()
    |> Enum.map(fn row -> format_row(row) end)
  end

# Take in a parsed row, and attempt to extract data.
# There are empty rows with 8 cells after the data, which we throw out.
# There is a message and 7 cells after those empty rows, which we also throw out.

  defp format_row([_head, "", "", "", "", "", ""]) do
    nil
  end

  defp format_row(["", "", "", "", "", "", "", ""]) do
    nil
  end

  defp format_row([date, fund, company, ticker, cusip, shares, market_value, weight]) do
    %{
      date: handle_date(date),
      fund: fund,
      company: company,
      ticker: ticker,
      cusip: cusip,
      shares: round_float(shares),
      market_value: round_float(market_value),
      weight: weight
    }
  end

  def handle_date(date) when is_binary(date) do
    date
    |> String.split("/")
    |> format_date()
    |> Date.from_iso8601!()
  end

  defp format_date([month, day, year]) do
    [m, d, y] = [month, day, year] |> pad_zeros()

    Enum.join([y, m, d],  "-")
  end

  defp format_date(_), do: "1970-01-01"

  def pad_zeros(list) do
    pad_zeros(list, [])
  end

  def pad_zeros([head | tail], state) do
    fixed = pad_zero(head)
    pad_zeros(tail, state ++ [ fixed ] )
  end

  def pad_zeros([], state), do: state

  def pad_zero(string) do
    case Kernel.byte_size(string) do
      1 -> "0" <> string
      _ -> string
    end
  end

  defp round_float(float) do
    case Integer.parse(float) do
      {int, _} -> int
      :error -> 0
    end
  end
end
