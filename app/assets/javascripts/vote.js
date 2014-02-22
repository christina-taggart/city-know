var Vote = {
  init: function() {
    $('a.vote').on('ajax:success', this.updateVoteCount);
  },

  updateVoteCount: function(event, data) {
    $('.vote-count-question').html(data);
  }
}

$(function(){
  Vote.init();
})