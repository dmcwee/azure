function decodeContent(controlId) {
    var encoded = $("#" + controlId).val();
    var result = decodeURIComponent(encoded);
    $("#" + controlId).val(result);
}