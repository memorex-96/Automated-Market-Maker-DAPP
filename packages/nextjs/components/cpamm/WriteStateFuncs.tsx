import { useScaffoldWriteContract } from "~~/hooks/scaffold-eth";
import { useState } from "react";
import { parseEther } from "viem";

export const WriteStateFuncs = () => {
    const [usr_amt0, setUsrAmt0] = useState("");
    const [usr_amt1, setUsrAmt1] = useState(""); 

    const { writeContractAsync, isPending } = useScaffoldWriteContract({
        contractName: "CPAMM"
    }); 

    const handleAddLiquidity = async () => {
       if (!usr_amt0 || !usr_amt1) return; 
       
       try {
            await writeContractAsync({
                functionName: "addLiquidity", 
                args: [parseEther(usr_amt0), parseEther(usr_amt1)], 
            });
            setUsrAmt0("");
            setUsrAmt1(""); 
       } catch (e) {
        console.error("Error adding liquidity: ", e); 
       }
    }

    const handleRemoveLiquidity = async () => {

    }

    const handleSwapLiquidity = async () => {

    }


    return(
        <div className="card bg-base-400 shadow-xl p-6 max-w-md gap-4">
            <h3 className="font-bold text-lg">Add Liquidity</h3>
            
            <div className="flex flex-col gap-3">
                {/* Token0 AMT input*/}
                <input
                    type="number"
                    placeholder="Amount of Token 0"
                    value={usr_amt0}
                    onChange={(e) => setUsrAmt0(e.target.value)}
                    className="input input-bordered w-full"
                />
                {/* Token1 AMT input */}
                <input
                    type="number"
                    placeholder="Amount of Token 1"
                    value={usr_amt1}
                    onChange={(e) => setUsrAmt1(e.target.value)}
                    className="input input-bordered w-full"
                />
                {/* Submit Button */}
                <button
                    onClick={handleAddLiquidity}
                    disabled={isPending || ! usr_amt0 || !usr_amt1}
                    className="btn btn-primary w-full"
                >
                    {isPending ? "Confirming..." : "Add Liquidity"}
                </button>
            </div> 
        </div>
    );
} 




