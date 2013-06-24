do ( jQuery ) ->
    $ = jQuery
    settings =
        variableName : true
        message : "hello world!"
        formCategories : "#form_categories"
        categoryMenu : "#category_menu"

    methods = 
        init: ( options ) ->
            this.each () ->
                $.extend(settings, options)
                $this = $ @
        
                methods.categoryMenu settings.categoryMenu



        # returns the query values of the URL
        getUrlQueries : () ->
            pl = /\+/g
            search = /([^&=]+)=?([^&]*)/g
            decode = (s) ->
                decodeURIComponent(s.replace(pl, " "))
            query = window.location.search.substring(1)
            urlParams = {}
            while (match = search.exec(query))
                urlParams[decode(match[1])] = decode(match[2])
            urlParams

        categoryMenu : ( categoryMenu ) ->
            $catUl = $(categoryMenu).find 'ul'
            $catExpand = $(categoryMenu).find('p').find('a')


            urlParams = methods.getUrlQueries()
            categoryVal = urlParams.category
            if categoryVal?
                console.log "#{ categoryVal} !!"
                catClass = ".cat_#{ categoryVal }"
                catName = $catUl.find(catClass).find('a').html()
                catString = "Viewing: #{ catName } "
                $catExpand.html(catString).append $('<span />').html('&#9661;')



            $(categoryMenu).on 'click', 'p a', (e) ->
                do e.preventDefault
                ulAriaState = $catUl.attr 'aria-expanded'
                if ulAriaState is 'false'
                    $catUl.attr 'aria-expanded', true
                    $(@).find('span').html '&#9651;'
                if ulAriaState is 'true'
                    $catUl.attr 'aria-expanded', false
                    $(@).find('span').html '&#9661;'

            $catUl.on 'click', 'a', (e) ->
                do e.preventDefault
                # urlParams = methods.getUrlQueries()
                # categoryVal = urlParams.category
                categoryVal = parseInt $(@).data('category'), 10
                if categoryVal is 0
                    window.location.href = "./?mode=index"
                else
                    window.location.href = "./?mode=index&category=#{ categoryVal }"



        categorySelect : ( formCategories ) ->
            console.log "foo"
            $(formCategories).on 'change', 'select', () ->
                do $(formCategories).submit
                console.log "oiuhjnk"


    $.fn.pluginName = ( method ) ->
        if methods[method]
            methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ) )
        else if typeof method is 'object' or not method
            methods.init.apply this, arguments
        else
            $.error 'Method ' + method + ' does not exist on jQuery.pluginName'