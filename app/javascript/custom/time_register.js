document.addEventListener('DOMContentLoaded', function() {
  // 毎秒ごとに時刻を更新する関数
  function updateClock() {
    var now = new Date();
    var hours = now.getHours();
    var minutes = now.getMinutes();
    var seconds = now.getSeconds();

    // ゼロパディング
    hours = hours < 10 ? '0' + hours : hours;
    minutes = minutes < 10 ? '0' + minutes : minutes;
    seconds = seconds < 10 ? '0' + seconds : seconds;

    // 時刻を表示する要素にセット
    document.getElementById('current-time').innerText = hours + ':' + minutes + ':' + seconds;
  }

  // 初回実行
  updateClock();

  // 1秒ごとにupdateClock関数を実行
  setInterval(updateClock, 1000);
});

