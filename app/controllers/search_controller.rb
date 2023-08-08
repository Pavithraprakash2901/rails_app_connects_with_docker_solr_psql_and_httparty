class SearchController < ApplicationController
   
        def search
          @query = params[:query]
         
          @search_results = perform_solr_search(@search_value)

          # Fetch data from Solr using RSolr
          solr = RSolr.connect(url: 'http://localhost:8983/solr/ums') # Replace 'forms' with your Solr core name
          response = solr.get('select', params: { q: @query })
      
      
          # Process the Solr response and extract the data
          @results = response['response']['docs']
        end
     
end
