local _M = {}
local mt = { __index = _M }

function _M.새서버만들기()
    return setmetatable({
        routes = {},
        beans = {}
    },mt)
end

function _M:가져오기(경로, 매니저)
    self.routes["GET:" .. 경로] = 매니저
end

function _M:실행()
    local uri = ngx.var.uri
    local method = ngx.req.get_method()
    local handler = self.routes[method .. ":" .. uri]

    if handler then
        local 요청 = {
            method = method,
            url = uri,
            query = ngx.req.get_uri_args()
        }

        local 응답 = {
            보내기 = function(self, 내용)
                ngx.header.content_type = "text/html; charset=utf-8"
                ngx.say(내용)
            end
        }
        handler(요청, 응답)
    else
        ngx.status = 404
        ngx.header.content_type = "text/html; charset=utf-8"
        ngx.say("페이지가 없어요!")
        return ngx.exit(ngx.HTTP_NOT_FOUND)
    end
end

return _M


