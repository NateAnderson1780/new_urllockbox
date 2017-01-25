$(document).ready(function(){
  $('#search_links').on('keyup', searchLinks);
  $('.filter-read').on('click', filterRead);
  $('.filter-unread').on('click', filterUnread);
})

function searchLinks(e) {
  
  var searchText = $('#search_links').val();
  $('.link').each(function(index) {
    var linkTitle = $( this ).find( '.link-title' ).text().split(': ')[1];
    var linkUrl = $( this ).find( '.link-url' ).text().split(': ')[1];
    
    if (linkTitle.includes(searchText) || linkUrl.includes(searchText)) {
      $(this).show()
    } else {
      $(this).hide()
    };
  });
}

function filterRead(e) {
  $('.link').each(function(index) {
    if ($(this).find('.link_read').text() == 'Read?: true') {
      $(this).show()
    } else {
      $(this).hide()
    }
  })
}

function filterUnread(e) {
  $('.link').each(function(index) {
    if ($(this).find('.link_read').text() == 'Read?: false') {
      $(this).show()
    } else {
      $(this).hide()
    }
  })
}