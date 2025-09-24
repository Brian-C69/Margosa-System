function calculateDuration(entryDate, entryTime, exitDate, exitTime) {
    // Calculate the duration of stay in days, hours, minutes, seconds
    var entryDateTime = new Date(entryDate + ' ' + entryTime);
    var exitDateTime = new Date(exitDate + ' ' + exitTime);

    var duration = exitDateTime - entryDateTime;

    var seconds = Math.floor(duration / 1000) % 60;
    var minutes = Math.floor(duration / (1000 * 60)) % 60;
    var hours = Math.floor(duration / (1000 * 60 * 60)) % 24;
    var days = Math.floor(duration / (1000 * 60 * 60 * 24));

    return days + "d " + hours + "h " + minutes + "m " + seconds + "s";
}