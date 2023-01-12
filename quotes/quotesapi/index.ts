/*
import { serve } from "https://deno.land/std@0.53.0/http/server.ts";
import { quotes } from './quotes';
const s = serve({port: 8000});
console.log("http://localhost:8000");

for await (const req of s){
    req.respond({body: 'Hello World\n'});
}
*/
import {
  Application,
  Router,
} from "https://deno.land/x/denotrain@v0.5.0/mod.ts";
import { quotes } from "./quotes.ts";

const app = new Application({hostname: "192.168.1.4"});
const router = new Router();
app.use("/api", router);

app.get("/", (ctx) => "Hello Ashish/n");

router.get("/quotes", (ctx) => { 
  return {"quotes": quotes} 
})

await app.run();
