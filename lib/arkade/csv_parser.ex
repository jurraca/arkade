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

  defp format_row([_head, "", "", "", "", "", ""]) do
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
    Enum.join([year, month, day], "-")
  end

  defp format_date([""]), do: "2100-01-01"

  defp round_float(float) do
    case Integer.parse(float) do
      {int, _} -> int
      :error -> 0
    end
  end
end
