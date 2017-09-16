ace.define("ace/mode/tlstatusnss_highlight_rules", ["require", "exports", "module", "ace/lib/oop", "ace/mode/text_highlight_rules"], function(require, exports, module) {
  "use strict";

  var oop = require("../lib/oop");
  var TextHighlightRules = require("./text_highlight_rules").TextHighlightRules;

  var NssHighlightRules = function() {
    this.$rules = {
      start: [{
          include: 'comment'
        },
        {
          include: 'block'
        },
        {
          include: 'tag'
        },
        {
          include: 'important_function_call'
        },
        {
          defaultToken: 'tlstatus.code'
        },
        {
          caseInsensitive: true
        }
      ],
      important_function_call: [{
          token: 'tlstatus.no-comment-code',
          regex: '(CreateText|SetBacklog)(\\s*)\\(',
          push: [{
              token: 'tlstatus.no-comment-code',
              regex: '\\)',
              next: 'pop'
            }, {
              include: 'no_comment_lparen'
            },
            {
              defaultToken: 'tlstatus.no-comment-code'
            }
          ]
        },
        {
          caseInsensitive: true
        }
      ],
      no_comment_lparen: [{
          token: 'tlstatus.no-comment-code',
          regex: '\\(',
          push: [{
              token: 'tlstatus.no-comment-code',
              regex: '\\)',
              next: 'pop'
            },
            {
              include: 'no_comment_lparen'
            },
            {
              defaultToken: 'tlstatus.no-comment-code'
            }
          ]
        },
        {
          caseInsensitive: true
        }
      ],
      comment: [{
          token: 'tlstatus.note',
          regex: '^\\/\\/note(.*)'
        },
        {
          token: 'comment.single-line',
          regex: '(^|\\s+)\\/\\/(.*)'
        },
        {
          include: 'multiline_comment'
        },
        {
          caseInsensitive: true
        }
      ],
      multiline_comment: [{ // yes, these are nestable in NSS
          token: 'comment.multiline',
          regex: '\\/\\*',
          push: [{
            token: 'comment.multiline',
            regex: '\\*\\/',
            next: 'pop'
          }, {
            defaultToken: 'comment.multiline'
          }, {
            include: 'multiline_comment'
          }]
      }],
      block: [{
          token: 'tlstatus.code',
          regex: '{',
          push: [{
            token: 'tlstatus.code',
            regex: '}',
            next: 'pop'
          }, {
            include: 'start'
          }]
        },
        {
          caseInsensitive: true
        }
      ],
      tag: [{
          token: 'tlstatus.code',
          regex: '<PRE(.*?)>',
          push: [{
            token: 'tlstatus.code',
            regex: '<\\/PRE>',
            next: 'pop'
          }, {
            include: 'text'
          }]
        },
        {
          token: 'tlstatus.code',
          regex: '<FONT(.*?)>',
          push: [{
            token: 'tlstatus.code',
            regex: '<\\/FONT>',
            next: 'pop'
          }, {
            include: 'text'
          }]
        },
        {
          token: 'tlstatus.code',
          regex: '<RUBY(.*?)>',
          push: [{
            token: 'tlstatus.code',
            regex: '<\\/RUBY>',
            next: 'pop'
          }, {
            include: 'text'
          }]
        },
        {
          token: 'tlstatus.code',
          regex: '<SPAN(.*?)>',
          push: [{
            token: 'tlstatus.code',
            regex: '<\\/SPAN>',
            next: 'pop'
          }, {
            include: 'text'
          }]
        },
        {
          token: 'tlstatus.code',
          regex: '<U(.*?)>',
          push: [{
            token: 'tlstatus.code',
            regex: '<\\/U>',
            next: 'pop'
          }, {
            include: 'text'
          }]
        },
        {
          token: 'tlstatus.code',
          regex: '<(voice|k|br)(.*)>'
        },
        {
          caseInsensitive: true
        }
      ],
      text: [{
          token: 'tlstatus.code',
          regex: '\\[text(\\d+)\\]'
        },
        {
          include: 'comment'
        },
        {
          include: 'tag'
        },
        {
          include: 'block'
        },
        {
          defaultToken: 'tlstatus.text'
        },
        {
          caseInsensitive: true
        }
      ]
    };

    this.normalizeRules();
  };

  oop.inherits(NssHighlightRules, TextHighlightRules);

  exports.NssHighlightRules = NssHighlightRules;
});

ace.define("ace/mode/tlstatusnss", ["require", "exports", "module", "ace/lib/oop", "ace/mode/text"], function(require, exports, module) {
  "use strict";

  var oop = require("../lib/oop");
  var TextMode = require("./text").Mode;
  var NssHighlightRules = require("./tlstatusnss_highlight_rules").NssHighlightRules;

  var Mode = function() {
    this.HighlightRules = NssHighlightRules;
    this.foldingRules = null;
    this.$behaviour = this.$defaultBehaviour;
  };
  oop.inherits(Mode, TextMode);

  (function() {
    this.$id = "ace/mode/tlstatusnss";
  }).call(Mode.prototype);

  exports.Mode = Mode;
});