import { useScaffoldWriteContract } from "~~/hooks/scaffold-eth";
import { useState } from "react";
import { parseEther } from "viem";
import { Address } from "viem";

export const WriteStateFuncs = () => {
    const [usr_amt0, setUsrAmt0] = useState("");
    const [usr_amt1, setUsrAmt1] = useState(""); 
    const [amtIn, setAmtIn] = useState(""); 
    const [usr_shares, setUserShares] = useState<string | null>(null);
    const [coin_adr, setCoinAddress] = useState(""); 
     

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
        if (!usr_shares) return; 
        try {
            await writeContractAsync({
                functionName: "removeLiquidity", 
                args: [parseEther(usr_shares)],
            });
            setUserShares(""); 
        } catch(e) {
            console.error("Error removing liquidity: ", e);
        }
    }

    const handleSwapLiquidity = async () => {
        try {
            {/** Call SwapLiquidity func, need to assign coin wallet addresses */}
            await writeContractAsync({
                functionName: "swap",
                args: [coin_adr, parseEther(amtIn)],
            }); 
            setCoinAddress(""); 
        } catch (e) {
            console.error("Error swapping: ", e);
        }
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
            <h3 className="font-bold text-lg">Remove Liquidity</h3>
            <div className="flex flex-col gap-3">
                {/**Token0 AMT input */}
                {/**Submit */}
                <button
                    onClick={handleRemoveLiquidity}
                    disabled={isPending || !usr_shares}
                    className="btn btn-primary w-full">
                        {isPending ? "Confirnimg" : "Remove Liquidity"}
                </button>
            </div>
            <h3 className="font-bold text-lg">Swap</h3>
            {/** 100% needs rework after testing */}
            <div className="flex flex-col gap-3">
                {/** Coin in*/}
                <input
                    type="address"
                    placeholder="Coin Address"
                    value={coin_adr}
                    onChange={(e) => setCoinAddress(e.target.value)}
                    className="input input-bordered w-full"/>
                {/** AmountIn */}
                <input
                    type="number"
                    placeholder="Amount Being traded"
                    value={amtIn}
                    onChange={(e) => setAmtIn(e.target.value)}
                    className="input input-bordered w-full"/>
                {/** Submit button */}
                <button
                    onClick={handleSwapLiquidity}
                    disabled={isPending}
                    className="btn btn-primary w-full">
                        {isPending ? "Confirming" : "Swap Liquidity"}
                </button>
            </div>
        </div>
    );
} 




