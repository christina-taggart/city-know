var Vote = {
  init: function() {
    $('a.vote-question').on('ajax:success', this.updateQuestionVoteCount);
    $('a.vote-answer').on('ajax:success', this.updateAnswerVoteCount);
  },

  updateQuestionVoteCount: function(event, data) {
    $('.vote-count-question').html(data);
  },

  updateAnswerVoteCount: function(event, data) {
    $(event.target).next()[0].innerHTML=data;
  }

}

$(function(){
  Vote.init();
})