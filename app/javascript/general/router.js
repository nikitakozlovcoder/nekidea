export class Router {
    
    callWhen(it, ...entrys) {
        console.log("current entry:");

        let currentEntry =  document.body.dataset.entry;
        console.log(currentEntry);
        entrys.forEach(element => {
            console.log(element);

            if(currentEntry == element)
            {
                console.log("hi!!!!!");
                it(currentEntry);
            }
                
        });
    }

    callAlways(it) {
        let currentEntry =  document.body.dataset.entry;
        it(currentEntry);

    };

}

