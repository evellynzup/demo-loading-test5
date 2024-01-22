package .api.controller

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.ResponseBody

interface IHelloWorldController {
    @GetMapping("{name}") @ResponseBody
    fun sayHello(@PathVariable name: String) : Map<String, Any>
}
