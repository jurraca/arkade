defmodule Arkade.Fetcher do 
    @moduledoc """
        Fetches the ETF data from the Ark website. 
    """

@base_url "https://ark-funds.com/wp-content/fundsiteliterature/csv/"
@arkk "ARK_INNOVATION_ETF_ARKK_HOLDINGS.csv"
@arkq "ARK_AUTONOMOUS_TECHNOLOGY_&_ROBOTICS_ETF_ARKQ_HOLDINGS.csv"
@arkw "ARK_NEXT_GENERATION_INTERNET_ETF_ARKW_HOLDINGS.csv"
@arkg "ARK_GENOMIC_REVOLUTION_MULTISECTOR_ETF_ARKG_HOLDINGS.csv"
@arkf "ARK_FINTECH_INNOVATION_ETF_ARKF_HOLDINGS.csv"
@prnt "THE_3D_PRINTING_ETF_PRNT_HOLDINGS.csv"
@izrl "ARK_ISRAEL_INNOVATIVE_TECHNOLOGY_ETF_IZRL_HOLDINGS.csv"

    def fetch do 
        [@arkk, @arkq, @arkw, @arkg, @arkf, @prnt, @izrl] 
        |> build_url([])
        |> request() 
    end 

    @doc """
        if the given list is not empty, take the state and append the full URL for the head arg. 
        recurse with the tail and the new state. 
    """
    def build_url([head | tail], state ) do 
        state = state ++ [@base_url <> head]
        build_url(tail, state)
    end 

    @doc """
        if the given list is empty, return the state. 
    """
    def build_url([], output), do: output

    def request([head | tail]) do 
        head
        |> HTTPoison.get()
        |> handle_response()
        #request(tail)
    end 

    def request([]), do: nil 

    def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do 
        body 
    end

    def handle_response({:ok, %HTTPoison.Response{status_code: status}}) do 
        {:error, status}
    end
end 

