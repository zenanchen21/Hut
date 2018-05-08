$ ->
  initialize_users_typeahead = ->
    users_typeahead = new Bloodhound(
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace(
        "name"
      ),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      prefetch: "/users/autocomplete"
    )

    users_typeahead.initialize()

    $(".js-user-autocomplete").typeahead null,
      displayKey: "name"
      source: users_typeahead.ttAdapter()

initialize_users_typeahead()
