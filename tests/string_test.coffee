describe 'emojify used with flat strings', ->

  describe 'with variations of spacing around 2char smileys', ->
    it 'works with no spacing around :)', ->
      el = "<div>:)</div>"
      result = emojify.run(el)
      assert.equal '<div><img title=\':blush:\' class=\'emoji\' src=\'images/emoji/blush.png\' align=\'absmiddle\' /></div>', result

    it 'works with spacing before :)', ->
      el = "<div> :)</div>"
      result = emojify.run(el)
      assert.equal '<div> <img title=\':blush:\' class=\'emoji\' src=\'images/emoji/blush.png\' align=\'absmiddle\' /></div>', result

    it 'works with spacing after :)', ->
      el = "<div>:) </div>"
      result = emojify.run(el)
      assert.equal '<div><img title=\':blush:\' class=\'emoji\' src=\'images/emoji/blush.png\' align=\'absmiddle\' /> </div>', result

    it 'works with spacing before and after :)', ->
      el = "<div> :) </div>"
      result = emojify.run(el)
      assert.equal '<div> <img title=\':blush:\' class=\'emoji\' src=\'images/emoji/blush.png\' align=\'absmiddle\' /> </div>', result

  describe 'with multiple emoji beside each other', ->
    it 'works with multiple :emoji: style', ->
      el = "<div>:railway_car::railway_car:</div>"
      result = emojify.run(el)
      assert.equal '<div><img title=\':railway_car:\' class=\'emoji\' src=\'images/emoji/railway_car.png\' align=\'absmiddle\' /><img title=\':railway_car:\' class=\'emoji\' src=\'images/emoji/railway_car.png\' align=\'absmiddle\' /></div>', result

    it 'works with multiple :) style', ->
      el = "<div>:):P</div>"
      result = emojify.run(el)
      assert.equal '<div><img title=\':blush:\' class=\'emoji\' src=\'images/emoji/blush.png\' align=\'absmiddle\' /><img title=\':stuck_out_tongue_winking_eye:\' class=\'emoji\' src=\'images/emoji/stuck_out_tongue_winking_eye.png\' align=\'absmiddle\' /></div>', result


  describe 'isolated cases', ->
    it ':neckbeard:', ->
      el = "<div>:neckbeard:</div>"
      result = emojify.run(el)
      assert.equal '<div><img title=\':neckbeard:\' class=\'emoji\' src=\'images/emoji/neckbeard.png\' align=\'absmiddle\' /></div>', result

    it 'inserts a <3 heart', ->
      el = "inserts a <3 heart"
      result = emojify.run(el)
      assert.equal 'inserts a <img title=\':heart:\' class=\'emoji\' src=\'images/emoji/heart.png\' align=\'absmiddle\' /> heart', result

    it 'works on an HTML escaped <3', ->
      el = "inserts a &lt;3 heart"
      result = emojify.run(el)
      assert.equal 'inserts a <img title=\':heart:\' class=\'emoji\' src=\'images/emoji/heart.png\' align=\'absmiddle\' /> heart', result

    it "works on :'(", ->
      el = "aww :'( aw :’("
      result = emojify.run(el)
      assert.equal 'aww <img title=\':sob:\' class=\'emoji\' src=\'images/emoji/sob.png\' align=\'absmiddle\' /> aw <img title=\':sob:\' class=\'emoji\' src=\'images/emoji/sob.png\' align=\'absmiddle\' />', result

    it "works on HTML escaped :'(", ->
      el = "aww :&#x27;( aw"
      result = emojify.run(el)
      assert.equal 'aww <img title=\':sob:\' class=\'emoji\' src=\'images/emoji/sob.png\' align=\'absmiddle\' /> aw', result

    it "I thought it'd run forever", ->
      el = "I thought it'd run forever"
      result = emojify.run(el)
      assert.equal el, result

    it "doesn't insert a smiley admist escaped HTML", ->
      el = "I thought it&#x27;d run forever"
      result = emojify.run(el)
      assert.equal el, result

    it ":)start of string without space does not emojify", ->
      el = ":)start of string without space"
      result = emojify.run(el)
      assert.equal el, result

    it ":) start of string with space emojifies", ->
      el = ":) start of string with space"
      result = emojify.run(el)
      assert.equal '<img title=\':blush:\' class=\'emoji\' src=\'images/emoji/blush.png\' align=\'absmiddle\' /> start of string with space', result

    it "end of string without space:) does not emojify", ->
      el = "end of string without space:)"
      result = emojify.run(el)
      assert.equal el, result

    it "end of string with space :) emojifies", ->
      el = "end of string with space :)"
      result = emojify.run(el)
      assert.equal 'end of string with space <img title=\':blush:\' class=\'emoji\' src=\'images/emoji/blush.png\' align=\'absmiddle\' />', result
