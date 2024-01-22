package .api.controller.impl

import .api.controller.IHelloWorldController
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.ResponseBody
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestMapping

@RestController
@RequestMapping("/v1/hello")
class HelloWorldController : IHelloWorldController {

    @GetMapping("/{name}") @ResponseBody
    override fun sayHello(@PathVariable name: String) : Map<String, Any> {
        return mapOf(
            "Hello" to name
        )
    }
}
