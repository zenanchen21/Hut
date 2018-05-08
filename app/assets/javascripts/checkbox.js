$(document).ready(function() {
  $("#tableOne thead tr td:first input:checkbox").click(function () {
    var checkedStatus = this.checked;
    $("#tableOne tbody tr td:first-child input:checkbox").each(function () {
      this.checked = checkedStatus;
    });
  });
})
