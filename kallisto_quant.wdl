workflow kallisto_quant {
    File index
    File reads1
    File reads2
    #mutually exclusive if both false, then unstranded
    Boolean forward_stranded
    Boolean reverse_stranded
    Int? ncpu
    Int? memGB
    String? kallisto_disks

    call kallisto { input:
        index = index,
        reads1 = reads1,
        reads2 = reads2,
        forward_stranded = forward_stranded,
        reverse_stranded = reverse_stranded,
        ncpu = ncpu,
        memGB = memGB,
        kallisto_disks = kallisto_disks
    }
}
    
    task kallisto {
        File index
        File reads1
        File reads2
        Boolean forward_stranded
        Boolean reverse_stranded
        Int? ncpu
        Int? memGB
        String? kallisto_disks


        command {
            kallisto quant \
                ${"-i " + index} \
                -o out \
                --plaintext \
                --rf-stranded \
                ${"-t " + ncpu} \
                ${reads1} ${reads2}
        }

        output {
            File abundances = glob("out/*.tsv")[0]
            File run_info = glob("out/run_info.json")[0]
        }

        runtime {
            docker: "quay.io/encode-dcc/kallisto:latest"
            cpu: select_first([ncpu,4])
            memory: "${select_first([memGB,8])} GB"
            disks: select_first([kallisto_disks, "local-disk 100 HDD"])
        }
    }