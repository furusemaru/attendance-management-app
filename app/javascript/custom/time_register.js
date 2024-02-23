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

    // 日付を取得
    var options = { month: 'long', day: 'numeric', weekday: 'short' };
    var currentDate = now.toLocaleDateString('ja-JP', options);

    // 日付、時刻を表示する要素にセット
    document.getElementById('current-date').innerText = currentDate;
    document.getElementById('current-time').innerText = hours + ':' + minutes + ':' + seconds;
  
    // 隠しフィールドに現在の日付を設定
    document.getElementById('hidden-date').value = now.toISOString().split('T')[0];
  }

  // 初回実行
  updateClock();

  // 1秒ごとにupdateClock関数を実行
  setInterval(updateClock, 1000);
});

      function clockIn() {
        // 出勤ボタンがクリックされたときの処理
        if (confirm('本当に出勤しますか？')) {
          document.getElementById('work_start_time').value = getCurrentTime();
        }
      }

      function clockOut() {
        // 退勤ボタンがクリックされたときの処理
        if (confirm('本当に退勤しますか？')) {
          document.getElementById('work_end_time').value = getCurrentTime();
        }
      }

      function getCurrentTime() {
        // 現在の時刻を取得する関数
        var now = new Date();
        var hours = now.getHours();
        var minutes = now.getMinutes();

        hours = hours < 10 ? '0' + hours : hours;
        minutes = minutes < 10 ? '0' + minutes : minutes;

        return hours + ':' + minutes;
      }

