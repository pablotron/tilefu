(function() {
  var D = document;

  var dom = (function() {
    function get(s, o) {
      return D['querySelector' + (o ? '' : 'All')](s);
    }

    function on(el, ev, fn) {
      return el.addEventListener(ev, fn, false);
    }

    function init(fn) {
      return on(D, 'DOMContentLoaded', fn);
    }

    return {
      get:  get,
      on:   on,
      init: init
    };
  })();

  // tile width, height, and padding
  var tw = 32, th = 32, tp = 1;

  function draw_tile(c, v) {
    c.fillRect(0, 0, tw, th);
    c.strokeRect(0, 0, tw, th);

    c.save();
    c.fillStyle = '#000';
    if (v !== null) {
      var vm = c.measureText(v);
      c.fillText(v, tp + tw / 2 - vm.width / 2, tp + th / 2);
    }
    c.restore();
  }

  function draw_board(c, s, hx, hy) {
    // clear board
    c.fillStyle = '#fff';
    c.fillRect(0, 0, 640, 640);

    var x, y;

    // create tile style
    var grad = c.createLinearGradient(0, 0, 0, th + 2 * tp);
    grad.addColorStop(0, '#00abeb');
    grad.addColorStop(1, '#0fd');
    c.fillStyle = grad;
    c.strokeStyle = '#333';

    // set tile text style
    c.font = 'bold 14pt sans-serif';
    c.textBaseline = 'middle';
    c.textAligh = 'center';

    for (x = 0; x < s; x++) {
      for (y = 0; y < s; y++) {
        c.save();
        c.translate((tp + x * (2 * tp + tw)), (tp + y * (2 * tp + th)));

        if (hx !== null && hy !== null && x == hx && y == hy)
          c.fillStyle = 'red';

        draw_tile(c, 'Y');
        c.restore();
      }
    }
  }

  dom.init(function() {
    var e, c;
    
    if (e = dom.get('#c', true)) {
      if (e.getContext && (c = e.getContext('2d'))) {
        var pos = dom.get('#pos', true), 
            ox, oy;

        // browser supports canvas, and we have the context
        draw_board(c, 16);

        // add mousemove handler
        dom.on(e, 'mousemove', function(ev) {
          var x = ev.offsetX, y = ev.offsetY, 
              tx = Math.floor(x / (2 * tp + tw)),
              ty = Math.floor(y / (2 * tp + th));

          if (x < (16 * (2 * tp + tw)) && y < (16 * (2 * tp + tw))) {
            if (tx != ox || ty != oy)
              draw_board(c, 16, tx, ty);

            ox = tx; 
            oy = oy;
          } else {
            draw_board(c, 16);
          }

          pos.innerHTML = 'pos: ' + [
            ev.offsetX,
            ev.offsetY
          ].join(', ');

          return true;
        });
      } else {
        // browser doesn't support canvas
      }
    }
  });
})();
