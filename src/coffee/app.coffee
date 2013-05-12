define (require) ->
  $ = require('jquery')

  pictureStrip: (picturecount) ->
    images = [
      'CBF041B1-C3D9-DFC9-9537-1DCBD5212E7E'
      '409CD0D5-1188-CDF9-2537-CA4AC8AAEE07'
      '963B333F-DE56-9777-D244-FD7BDF76A839'
      '74C6AD63-7A1B-642A-DCC5-F0AF58A1D508'
      '38576F9C-95EC-E77A-1A86-BDBF81342E55'
      '3EF57521-F0C4-8AF9-4AF6-02B6B5447EA2'
      'D5E181D0-3E4E-FFDD-D17C-C92F344493CB'
      '27A5CC0E-4B5B-7F65-2A8A-19F80F9C397B'
      '3BE26254-BEFF-3F7A-7F20-538B6CDA6B64'
      '9CF6B96B-346D-6AA0-B768-17E3A1BDBA9B'
      '4CEDAE7A-7CFF-5575-7ACA-3676C9A825AE'
      'D1BC5CDC-2AED-87F7-C9BE-9D765CE02626'
      '10DE02B8-B9AD-3660-30D3-D9151A70B4C2'
      '3910ED18-49A8-4F98-B77C-827003367CAF'
      '312812F7-3426-1805-9200-ADFCED30C5D0'
      '625AF3D5-9A81-D201-1E1E-527BDBFEE1E7'
      '0505CB28-AF2C-8BC6-5276-07699835A171'
      '226B67CA-DC40-DA08-1A31-AE3BF9DDCB71'
      '72B2828F-9BF9-6A94-230D-FB10C15E75F7'
      'C1730F23-835B-0713-2728-A65D4A354C39'
      '47C05986-96F1-611C-DBA1-E05415F86DB2'
    ]
    
    i = $("#images img").length

    while i < picturecount
      nro = i
      calc = Math.floor i / (images.length)
      nro = i - (images.length * calc)  if calc >= 1

      #$("#images").css 'width', (133 * picturecount)

      width = 133

      if i+1 is picturecount
        width = 133 - (picturecount * 133 - $(window).width())

      $("#images").append '<img src="http://kuvauppi.fi/view/output/GUID/' + images[nro] + '/size/thumbnail" style="width: ' + width + 'px; height: 100px" />'


      i++

  onWindowResize: ->
    picturecount = Math.ceil $(window).width() / 133
    @pictureStrip picturecount


  sortGroup: (a, b) ->
    if a.group == b.group
      return 0

    return a.group > b.group ? 1 : -1;

  loadParticipates: ->
    $.getJSON '/participates.json', (data) ->
      #data = $(data).sort @sortGroup

      sorted = data.participates.sort (a, b) ->
        result = -(a.other.localeCompare b.other)
        if result is 0
          result = a.group.localeCompare b.group
          if result is 0
            result = a.name.localeCompare b.name

        result

      $.each sorted, (key, val) ->
        text = '<tr>
            <td>' + (key+1) + '</td>
            <td>' + val.nick + '</td>
            <td>' + val.name + '</td>
            <td>' + val.location + '</td>'

        if val.coming is 0
          text += '<td class="color certainly">Varmasti</td>'
        else if val.coming is 1
          text += '<td class="color likely">Todennäköisesti</td>'
        else
          text += '<td class="color maybe">Ehkä</td>'

        text += '<td>' + val.group + '</td><td></td><td></td><td>' + val.other + '</td><td></td></tr>';

        $('#people tr:last').after text

  main: ->
    #picturecount = Math.ceil $(window).width() / 133
    #@pictureStrip picturecount
    #@loadParticipates()

    $("table#people").on 'click', 'tr', (e) ->
      $(@).toggleClass "click"
      e.preventDefault()

    console.log $("table#people tr")