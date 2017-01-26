var $newLinkTitle, $newLinkUrl;

$(document).ready(function(){
  $newLinkTitle = $("#link-title");
  $newLinkUrl  = $("#link-url");

  $("#new-link").on('submit', createLink);
  
  $.get('https://shielded-forest-19678.herokuapp.com/api/v1/hot_reads')
   .then(renderHotAndTop)
})

function createLink (event){
  event.preventDefault();

  console.log("win")

  var link = getLinkData();

  $.post("/api/v1/links", link)
   .then( renderLink )
   .fail( displayFailure )
 }

function getLinkData() {
 return {
   title: $newLinkTitle.val(),
   url: $newLinkUrl.val()
 }
}

function renderLink(link){
  $("#links-list").prepend( linkHTML(link) )
  clearLink();
}

function linkHTML(link) {

    return `<div class='link' data-id='${link.id}' id="link-${link.id}">
              <p class='link-title'>Title: ${ link.title }</p>
              <p class='link-url'>URL: ${ link.url }</p>

              <p class="link_read">
                Read?: ${ link.read }
              </p>
              <p class="link_buttons">
                <button class="mark-read">Mark as Read</button>
                <button class='edit-link'><a href='/links/${link.id}/edit'>Edit</a></button>
              </p>
            </div>`
}

function clearLink() {
  $newLinkTitle.val("");
  $newLinkUrl.val("");
}

function displayFailure(failureData){
  $('.alert').html("FAILED attempt to create new Link: " + failureData.responseText);
  clearLink();
}

function renderHotAndTop(hotReads) {
  $("#links-list").children().each(function() {
    var url = $(this).find('.link-url').text().split(": ")[1]
  
    if (url == hotReads[0].url) {
      $(this).find('#top').text('TOP');
    } else if(checkHotStatus(hotReads, url)) {
      $(this).find('#hot').text('HOT');
    }
  })
}

function checkHotStatus (hotReads, url) {
  for (var index = 0; index < hotReads.length; index++) {
    var read = hotReads[index];
    
    if(read.url == url) {
      return true
    }
  }
}

 
 
