local 서버 = require("core")
local 앱 = 서버.새서버만들기()

앱:가져오기("/hello", function(요청, 응답)
    응답:보내기("안녕하세여! 루아 스프링입니다!")
end)

return 앱