export class Router {
    
    callWhen(it, ...entrys) {

        let currentEntry =  document.body.dataset.entry;
        entrys.forEach(element => {

            if(currentEntry == element)
            {
                it(currentEntry);
            }
                
        });
    }

    callAlways(it) {
        let currentEntry =  document.body.dataset.entry;
        it(currentEntry);

    };

}

