var $newLinkTitle, $newLinkUrl;

$(document).ready(function(){

  $('#links-list').on('click', 'button.mark-read', markRead);
  $('#links-list').on('click', 'button.mark-unread', markUnread);
  
  $('#links-list').children().each(function() {
    readStatus = $(this).find('.link_read').text()
    read = readStatus.split(': ')[1]
    if (read == 'true') {
      $(this).addClass('read')
      var readButton = $(this).find('.mark-read')
      readButton.removeClass('mark-read')
      readButton.addClass('mark-unread')
      readButton.html("Mark Unread")
    }
  })
})

function markRead(e) {
    event.preventDefault();
  
    var $this = $(this);
    var linkId = $this.parents('.link').data('id');
    
    $.ajax({
      url: '/api/v1/links/' + linkId,
      method: 'PATCH',
      data: {read: true}
    })
    .then(changeStatusToRead.bind(linkId)())
    .then(sendToHotReads.bind($this)())
}

function sendToHotReads() {
  var linkUrl = $(this).parent().siblings('.link-url').text().split(': ')[1];
  
  $.ajax({
    url: "https://shielded-forest-19678.herokuapp.com/api/v1/hot_reads",
    method: 'POST',
    data: {url: linkUrl}
  })
}

function markUnread(e) {
    event.preventDefault();
    
    var $this = $(this);
    var linkId = $this.parents('.link').data('id');
    
    $.ajax({
      url: '/api/v1/links/' + linkId,
      method: 'PATCH',
      data: {read: false}
    })
    .then(changeStatusToUnread.bind(linkId)())
}

function changeStatusToRead() {
    $('#link-' + this).addClass('read')

    var button = $('#link-' + this).find('.mark-read');
    button.removeClass('mark-read')
    button.addClass('mark-unread')
    button.html("Mark Unread")
    button.parent().parent().find('.link_read').text("Read?: true")
}

function changeStatusToUnread() {
  $('#link-' + this).removeClass('read')
    var button = $('#link-' + this).find('.mark-unread')
    button.removeClass('mark-unread')
    button.addClass('mark-read')
    button.html("Mark as Read")
    button.parent().parent().find('.link_read').text("Read?: false")
}
